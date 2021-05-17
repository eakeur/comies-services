import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, ManyToMany} from "typeorm";
import {Product} from "./product";
import {ItemGroup} from './item-group';

@Entity()
export class Item {

    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => ItemGroup, group => group.items)
    group: ItemGroup;

    @Column({nullable: false})
    groupId: number;

    @ManyToOne(() => Product, product => product.orders, { eager: true })
    product: Product;

    @Column({nullable: false})
    productId: number;

    @Column({nullable: false, type:"float", default: 1})
    quantity: number;

    @Column({nullable: false, default: false})
    done: boolean;

}