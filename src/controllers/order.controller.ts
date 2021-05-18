import { Controller, Param, Body, Get, Post, Put, Delete, State, UseBefore, UploadedFile, HeaderParams, Params, Req, QueryParams, Authorized, CurrentUser } from "routing-controllers";
import { Order, Operator, OrderFilter } from '../data';
import { json } from 'body-parser'
import {OrderService} from "../services";
import { KitchenController } from "./kitchen.controller";
import { StandardController } from "../core";

@Controller("/orders")
export class OrderController extends StandardController {

    @Authorized('getOrders')
    @Get("/:id")
    public async getOrderByID(@CurrentUser({required:true}) operator: Operator, @Param("id") id:number){
        const service:OrderService = new OrderService(operator);
        return service.get(id);
    }

    @Authorized('getOrders')
    @Get("")
    public async getOrders(@CurrentUser({required:true}) operator: Operator, @QueryParams() params: OrderFilter){
        const service:OrderService = new OrderService(operator);
        return service.getMany(params);
    }

    @Authorized('addOrders')
    @Post("")
    @UseBefore(json())
    public async addOrder(@CurrentUser({required:true}) operator: Operator, @Body() order:Order){
        const service:OrderService = new OrderService(operator);
        const response = await service.add(order);
        //if (response.success) KitchenController.sendOrderToKitchen(order, operator.partner.id, operator.store.id);
        return response;
    }

    @Authorized('updateOrders')
    @Put("")
    @UseBefore(json())
    public async updateOrder(@CurrentUser({required:true}) operator: Operator, @Body() order:Order){
        const service:OrderService = new OrderService(operator);
        const response = await service.update(order);
        //if (response.success) KitchenController.sendOrderToKitchen(order, operator.partner.id, operator.store.id);
        return response;
    }

    @Authorized('removeOrders')
    @Delete("")
    @UseBefore(json())
    public async removeOrder(@CurrentUser({required:true}) operator: Operator, @Body() order:Order){
        const service:OrderService = new OrderService(operator);
        return service.remove(order.id);
    }

}