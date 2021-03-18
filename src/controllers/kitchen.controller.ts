import Order from "../structures/order";
import {IncomingMessage, Server} from 'http';
import * as WebSocket from 'ws';
import Operator from "../structures/operator";
import OrderService from "../services/order.service";
import { Status } from "../structures/enums";

export class KitchenController {

    private static socket: WebSocket.Server;
    private static rooms: Map<number, Map<number, Map<string, WebSocket>>> = new Map<number, Map<number, Map<string, WebSocket>>>();

    public static openKitchen(socket: WebSocket.Server) : void {
        KitchenController.socket = socket;
    }

    public static async addClient(client: WebSocket, partnerID: number, storeID: number, operator: Operator, isTV: boolean){
        const letterIN = String.fromCharCode(65 + Math.floor(Math.random() * 26));
        const letterFI = String.fromCharCode(65 + Math.floor(Math.random() * 26));
        const reqTime = new Date(Date.now());
        const code = letterIN + partnerID + reqTime.getMinutes() + letterFI + storeID;
        if (isTV){
            if (KitchenController.rooms.has(partnerID)){
                if (KitchenController.rooms.get(partnerID).has(storeID)) KitchenController.rooms.get(partnerID).get(storeID).set(code, client);
                else {
                    const map = new Map<string, WebSocket>(); map.set(code, client);
                    KitchenController.rooms.get(partnerID).set(storeID, map);
                }
            } else {
                const orderMap = new Map<string, WebSocket>();
                const storemap = new Map<number, Map<string, WebSocket>>();
                orderMap.set(code, client);
                storemap.set(storeID, orderMap);
                KitchenController.rooms.set(partnerID, storemap);
            }
            const returns: SocketTransmission = {sender: "server", code, data: (await new OrderService(operator).getOrders(new Order())).data, type: "pan-initial", value: ""}
            client.send(JSON.stringify(returns));
        } else {
            const returns: SocketTransmission = {sender: "server", code:"", data: (await new OrderService(operator).getOrders(new Order())).data, type: "spoon-initial", value: ""}
            client.send(JSON.stringify(returns));
        }
    }

    public static removeClient(client: WebSocket, partnerID: number, storeID: number, isTV: boolean){
        if (isTV){
            KitchenController.rooms.get(partnerID).get(storeID).forEach((v, k) => {
                if (v === client) KitchenController.rooms.get(partnerID).get(storeID).delete(k);
            })
        }
    }

    public static sendOrderToKitchen(order: Order): void{
        if (KitchenController.rooms.has(order.store.partner.id)){
            if(KitchenController.rooms.get(order.store.partner.id).has(order.store.id)){
                KitchenController.rooms.get(order.store.partner.id).get(order.store.id).forEach(client => {
                    client.send(JSON.stringify([order]));
                });
            }
        }
    }

    public static receiveSocket(message: any, route: string[]){
        try {
            const reception = JSON.parse(message) as SocketTransmission;
            const code = reception.code;
            delete reception.code;
            KitchenController.rooms.get(Number.parseInt(route[0], 10)).get(Number.parseInt(route[1], 10)).get(code).send(JSON.stringify(reception));
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