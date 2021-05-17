import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, ManyToMany, OneToMany} from "typeorm";
import { Unity } from "../enums/enums";
import {Item} from "./item";
import {Partner} from "./partner";

@Entity()
export class Product {

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

    @Column({nullable: true})
    tags: string;

    @Column({nullable:false, type:"float"})
    value: number;

    @Column({nullable:false, type:"float"})
    price: number;

    @ManyToOne(() => Partner, partner => partner.products)
    partner:Partner;

    @Column({nullable:false})
    partnerId: number;

    @ManyToOne(() => Partner, partner => partner.products)
    partner:Partner;

    @OneToMany(() => Item, item => item.product)
    orders: Item[];

    @Column({default: true})
    active:boolean;

}