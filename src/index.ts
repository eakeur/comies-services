import {Connection} from  './core/connection'
import "reflect-metadata";
import express from 'express';
import {Express} from 'express';
import {Action, useExpressServer} from 'routing-controllers';
import session from 'express-session';
import MemoryStore  from 'memorystore';
import servefiles from "serve-static";
import * as WebSocket from 'ws';
import { IncomingMessage, Server } from 'http';
import {decode} from "querystring";
import createMemoryStore from 'memorystore';
import {AuthenticationController, CostumerController, ProductController, OrderController, OperatorController, KitchenController} from './controllers';

class ServerInitializer {

    public static start(){
        const init = new ServerInitializer();
    }

    constructor(){
        this.getDatabaseConnection()
            .then(() => this.initializeServer()
        );
    }

    public async getDatabaseConnection(){
        await Connection.connect();
        await Connection.initializeDatabase();
    }

    public buildApplication(application: Express){
        application = application.use("/", servefiles("public"));

        const MemoryStore = createMemoryStore(session);
        application = application.use(session({
            cookie: { maxAge: 86400000},
            secret: '2001Comies@))!',
            store: new MemoryStore({
                checkPeriod: 86400000
            })
        }));
        return application;

    }

    public async initializeServer(){
        const port = process.env.PORT || 8080;
        
        const server = useExpressServer(this.buildApplication(express()), {
            cors: true,
            currentUserChecker: (action: Action) => new AuthenticationController().getOperatorByToken(action),
            classTransformer:true,
            authorizationChecker:  (action: Action, roles: any[]) => new AuthenticationController().authorizeOperator(action, roles),
            controllers: [CostumerController, ProductController, OrderController, OperatorController, AuthenticationController]
        }).listen(port);
        await this.openRooms(server);

        console.log(`Comies server started on port ${port}`);
    }

    public async openRooms(server: Server){
        const socket: WebSocket.Server = new WebSocket.Server({ server });
        KitchenController.openKitchen(socket);
        socket.on("connection", async (srv: WebSocket, req: IncomingMessage) => {
            try {
                const routes = req.url.split('/');
                const operator = await new AuthenticationController().getOperatorBySocketToken(req.headers.authorization || decode(req.headers.cookie).authorization as string);
                if (operator){
                    console.log('Operator '+operator.id+' from store '+operator.store.id+' connected to the socket '+routes[1]+' with address ' + req.socket.remoteAddress);
                    const partnerID = Number.parseInt(routes[2], 10);
                    const storeID = Number.parseInt(routes[3], 10);
                    if ( partnerID === operator.partner.id && storeID === operator.store.id){
                        switch (routes[1]) {
                            case "": srv.close(); break;
                            case "kitchen": KitchenController.addClient(srv, partnerID, storeID, operator, routes[4] === "TV"); break;
                            default: srv.close(); break;
                        }
                        srv.on("message", (message: any) => {
                            switch (routes[1]) {
                                case "": srv.close(); break;
                                case "kitchen": KitchenController.receiveSocket(message, routes.slice(2)); break;
                                default: srv.close(); break;
                            }
                        });
                        srv.onclose = (event: WebSocket.CloseEvent) => {
                            switch (routes[1]) {
                                case "": break;
                                case "kitchen": KitchenController.removeClient(srv, partnerID, storeID, routes[4] === "TV"); break;
                                default: break;
                            }
                            console.log("Client on store "+storeID+" disconnected from socket");
                        };
                    } else srv.close();
                } else srv.close();
            } catch (error) {
                srv.close();
            }
        })
    }
}
ServerInitializer.start();
