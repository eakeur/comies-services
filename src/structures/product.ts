import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, ManyToMany, OneToMany} from "typeorm";
import { Unity } from "./enums";
import ProductItem from "./order-items";
import Partner from "./partner";

@Entity()
export default class Product {

    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable:false})
    name: string;

    @Column({nullable:false})
    code: string;

    @Column({nullable:false, default:1, type:"float"})
    min: number;

    @Column({nullable:false})
    unity: Unity;

    @Column({nullable:false, type:"float"})
    price: number;

    @ManyToOne(() => Partner, partner => partner.products)
    partner:Partner;

    @OneToMany(() => ProductItem, order => order.product)
    orders: ProductItem[];

    @Column({default: true})
    active:boolean;

}