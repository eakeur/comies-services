import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, ManyToMany} from "typeorm";
import Order from "./order";
import Product from "./product";

@Entity()
export default class ProductItem {

    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Order, order => order.items)
    order: Order;

    @Column({nullable: false})
    group: number;

    @ManyToOne(() => Product, product => product.orders, { eager: true })
    product: Product;

    @Column({nullable: false, type:"float"})
    quantity: number;

    @Column({nullable: false, default: false})
    done: boolean;

    @Column({nullable: false, type:"float"})
    discount: number;




}