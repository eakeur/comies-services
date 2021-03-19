import Order from "../structures/order";
import {IncomingMessage, Server} from 'http';
import * as WebSocket from 'ws';
import Operator from "../structures/operator";
import OrderService from "../services/order.service";
import { Status } from "../structures/enums";

export class KitchenController {

    private static socket: WebSocket.Server;
    private static pans: Map<number, Map<number, Map<string, WebSocket>>> = new Map<number, Map<number, Map<string, WebSocket>>>();
    private static spoons: Map<number, Map<number, WebSocket[]>> = new Map<number, Map<number, WebSocket[]>>();

    public static openKitchen(socket: WebSocket.Server) : void {
        KitchenController.socket = socket;
    }

    public static async addClient(client: WebSocket, partnerID: number, storeID: number, operator: Operator, isTV: boolean){
        const letterIN = String.fromCharCode(65 + Math.floor(Math.random() * 26));
        const letterFI = String.fromCharCode(65 + Math.floor(Math.random() * 26));
        const reqTime = new Date(Date.now());
        const code = letterIN + partnerID + reqTime.getMinutes() + letterFI + storeID;
        if (isTV){
            if (KitchenController.pans.has(partnerID)){
                if (KitchenController.pans.get(partnerID).has(storeID)) KitchenController.pans.get(partnerID).get(storeID).set(code, client);
                else {
                    const map = new Map<string, WebSocket>(); map.set(code, client);
                    KitchenController.pans.get(partnerID).set(storeID, map);
                }
            } else {
                const orderMap = new Map<string, WebSocket>();
                const storemap = new Map<number, Map<string, WebSocket>>();
                orderMap.set(code, client);
                storemap.set(storeID, orderMap);
                KitchenController.pans.set(partnerID, storemap);
            }
            const returns: SocketTransmission = {sender: "server", code, data: (await new OrderService(operator).getOrders(new Order())).data, type: "pan-initial", value: ""}
            client.send(JSON.stringify(returns));
        } else {
            if (KitchenController.spoons.has(partnerID)){
                if (KitchenController.spoons.get(partnerID).has(storeID)) KitchenController.spoons.get(partnerID).get(storeID).push(client);
                else KitchenController.spoons.get(partnerID).set(storeID, [client]);
            } else {
                const storemap = new Map<number, WebSocket[]>();
                storemap.set(storeID, [client]);
                KitchenController.spoons.set(partnerID, storemap);
            }
            const returns: SocketTransmission = {sender: "server", code:"", data: (await new OrderService(operator).getOrders(new Order())).data, type: "spoon-initial", value: ""}
            client.send(JSON.stringify(returns));
        }
    }

    public static removeClient(client: WebSocket, partnerID: number, storeID: number, isTV: boolean){
        if (isTV){
            KitchenController.pans.get(partnerID).get(storeID).forEach((v, k) => {
                if (v === client) KitchenController.pans.get(partnerID).get(storeID).delete(k);
            })
        } else {
            KitchenController.spoons.get(partnerID).get(storeID).forEach((v, index, arr) => {
                if (v === client) arr.splice(index, 1);
            });
        }
    }

    public static async sendOrderToKitchen(order: Order, partner: number, store: number): Promise<void>{
        const returns: SocketTransmission = {sender: "server", code:"", data: [order], type: "order-update", value: ""}
        if (KitchenController.pans.has(partner)){
            if(KitchenController.pans.get(partner).has(store)){
                KitchenController.pans.get(partner).get(store).forEach(client => {
                    client.send(JSON.stringify(returns));
                });
            }
        }
        if (KitchenController.spoons.has(partner)){
            if(KitchenController.spoons.get(partner).has(store)){
                KitchenController.spoons.get(partner).get(store).forEach(client => {
                    client.send(JSON.stringify(returns));
                });
            }
        }
    }

    public static receiveSocket(message: any, route: string[]){
        try {
            const reception = JSON.parse(message) as SocketTransmission;
            const code = reception.code;
            delete reception.code;
            KitchenController.pans.get(Number.parseInt(route[0], 10)).get(Number.parseInt(route[1], 10)).get(code).send(JSON.stringify(reception));
        } catch (error) {
            console.log("Error broadcasting message of client: "+error);
        }
    }
}


interface SocketTransmission {
    sender: string,
    code: string;
    data: Order[];
    type: string;
    value: string;
}