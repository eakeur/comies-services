import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, ManyToMany} from "typeorm";
import {Order} from "./order";
import {Item} from './item';
import {Product} from "./product";

@Entity()
export class ItemGroup {

    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Order, order => order.items)
    order: Order;

    @Column({nullable: false})
    orderId: number;

    @Column({nullable: false, default: 1})
    quantity: number;

    @OneToMany(() => Item, item => item.group)
    items: Item[];
    
    @Column({nullable: false, default: false})
    done: boolean;

    @Column({nullable: false, type:"float"})
    discount: number;

    @Column({nullable: false, type:"float"})
    price: number;

    @Column({nullable: false, type:"float"})
    finalprice: number;

}