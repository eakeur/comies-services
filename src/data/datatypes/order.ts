import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, ManyToMany, JoinTable, AfterInsert, AfterUpdate} from "typeorm";
import {Costumer} from "./costumer";
import {Store} from "./store";
import {ItemGroup} from "./item-group";
import { DeliverType, PaymentMethod, Status } from "../enums/enums";
import {Operator} from "./operator";
import {Address} from "./address";

@Entity()
export class Order {

    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    placed: Date;

    @Column({nullable:false, default:Status.pending})
    status: Status;

    @Column({nullable:false, default:PaymentMethod.cash})
    payment: PaymentMethod;

    @Column({nullable:false, default:DeliverType.takeout})
    deliverType: DeliverType;

    @ManyToOne(() => Address, address => address.orders, {eager:true})
    address: Address;

    @Column({ nullable: true })
    addressId: number;

    @ManyToOne(() => Store, store => store.orders)
    store: Store;

    @Column({ nullable: false })
    storeId: number;

    @ManyToOne(() => Costumer, costumer => costumer.orders, {eager: true})
    costumer: Costumer;

    @Column({ nullable: false })
    costumerId: number;

    @ManyToOne(() => Operator, operator => operator.orders)
    operator: Operator;

    @Column({ nullable: false })
    operatorId: number;

    @OneToMany(() => ItemGroup, productItem => productItem.order, {cascade: true, eager:true})
    items: ItemGroup[];

    @Column({nullable: false, type:"float"})
    price: number;

    @Column({nullable: false, type:"float"})
    finalprice: number;

    @Column()
    observations: string;

    @Column({default: true})
    active: boolean;



}