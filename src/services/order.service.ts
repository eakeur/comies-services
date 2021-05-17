import {OrdersCollection, ProductsCollection, Order, Service, OrderFilter, Operator, Enums, ItemGroup, Costumer } from '../data';
import {ForbiddenError, InvalidInformationError, MissingInformationError, Validators, UnauthorizedError} from '../core';
import {FindConditions, FindManyOptions} from 'typeorm';
export class OrderService implements Service<Order, number> {

    constructor(operator: Operator){
        if (operator === undefined || operator === null) throw new UnauthorizedError();
        this.operator = operator;
        this.cart = new Array<ItemGroup>();
    }

    cart: ItemGroup[];

    operator: Operator;

    public async add(order: Order): Promise<Order>{
        try {
            if (!this.operator.profile.canAddOrders) throw new ForbiddenError();
            order.items = this.cart;
            await this.validate(order);
            await OrdersCollection.save(order);
            return order;
        } catch (error) {
            console.error(error.message);
        }
    }

    public async remove(orderId: number): Promise<Order>{
        try {
            if (!this.operator.profile.canRemoveCostumers) throw new ForbiddenError();
            if (!Validators.stringIsValid(orderId.toString())) throw new MissingInformationError();
            const deleted = await OrdersCollection.remove({id: orderId} as Order);
            return deleted;  
        } catch (error) {
            console.error(error);
        }
    }

    public async update(order: Order): Promise<Order>{
        try {
            if (!this.operator.profile.canUpdateOrders) throw new ForbiddenError();
            if (!Validators.stringIsValid(order.id.toString())) throw new MissingInformationError();
            this.validate(order);
            const changes = {
                payment: order.payment, deliverType: order.deliverType,
                addressId: order.addressId, storeId: order.storeId,
                observations: order.observations, active: order.active,
            } as Order;
            await OrdersCollection.update(order.id, changes);
            return changes;
        } catch (error) {
            console.error(error)
        }
    }

    public async get(id: number): Promise<Order>{
        try {
            if (!this.operator.profile.canGetOrders) throw new ForbiddenError();
            if (!Validators.stringIsValid(id.toString())) throw new MissingInformationError();
            const order = await OrdersCollection.findOne(id);
            return order;
            
        } catch (error) {
            console.error(error.message);
        }
    }

    public async getMany(filters: OrderFilter): Promise<Order[]>{
        try {
            if (!this.operator.profile.canGetOrders) throw new ForbiddenError();
            if (filters.id) return [ (await this.get(filters.id)) ]; 

            const conditions: FindConditions<Order> = {};
            var query = OrdersCollection.createQueryBuilder('order');
            query.where()

            if (filters.clientId) query 
            else if (filters.clientId){
                if (Validators.stringIsValid(filters.clientPhone))
                options.
            } else 
            const ent = await OrdersCollection.find(filters);
            return ent;
        } catch (error) {
            console.error(error);
        }
    }

    public async changeStatus(orderID: number, currentStatus: Enums.Status, forward: boolean): Promise<Enums.Status> {
        try {
            let nextStatus: Enums.Status;
            forward
                ? currentStatus >= Enums.Status.delivered ? nextStatus = Enums.Status.finished : nextStatus = currentStatus + 1
                : currentStatus <= Enums.Status.pending ? nextStatus = Enums.Status.pending : nextStatus = currentStatus - 1
            await OrdersCollection.createQueryBuilder().update({id: orderID}).set({status: nextStatus}).execute();
            return nextStatus;
        } catch (error) {
            console.log(error);
            throw error;
        }
    }

    public async setCart(groups: ItemGroup[]): Promise<ItemGroup[]> {
        try {
            this.validateItems(groups);
            await groups.forEach(async group => {
                const discount =  1 - group.discount / 100;
                const val = await group.items.map(async (item) => {
                    const prod = await ProductsCollection.findOne(item.productId, {select: ['price']});
                    return (item.quantity * prod.price);
                }).reduce(async (sum, value) => await sum + await value);
                group.price = val;
                group.finalprice = val * discount;
            });
            this.cart = groups;
            return groups;
        } catch (error) {
            console.error(error);
            throw error;
        }
    }
    
    private async validate(order: Order): Promise<void>{
        try {

            if (order.deliverType === Enums.DeliverType.delivery && order.addressId === undefined)
                throw new MissingInformationError('Pedidos para entrega precisam de um endereço');
            const noItemErr = new MissingInformationError('Um pedido precisa de ao menos um item');
            if (!order.items) throw noItemErr; if (order.items.length > 0) throw noItemErr;
            await this.validateItems(order.items);

        } catch (error) {
            
        }
    }

    private validateItems(items: ItemGroup[]){
        try {
            items.forEach(group => {
                if (group.discount){
                    if (group.discount < 0 && group.discount > 100) 
                        throw new InvalidInformationError(`O desconto com valor de ${group.discount}% é inválido.`);
                    // if (group.discount > PERMITIDO POR EMPRESA)
                    //     throw new InvalidInformationError(`O desconto com valor de ${group.discount}% não é permitido pelo restaurante.`);
                }
                if (!group.items) throw new MissingInformationError('É preciso inserir ao menos um item.');
                if (group.items.length > 0) throw new MissingInformationError('É preciso inserir ao menos um item.');
                if (group.items.map(item => item.quantity).reduce((acc, add) => acc + add) !== 1) throw new InvalidInformationError('A soma de todos os itens em um grupo deve resultar em um.');
                if (!Number.isInteger(group.quantity)) throw new InvalidInformationError('A quantidade de um item deve resultar em um inteiro.');
            });

        } catch (error) {
           console.error(error); 
        }
    }


}