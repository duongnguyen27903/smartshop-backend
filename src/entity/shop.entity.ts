import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Users } from "./user.entity";

@Entity('car_types')
export class CarTypes {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ type: "varchar", length: 50, unique: true })
    name: string
}

@Entity({ name: 'brands' })
export class Brands {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ type: 'varchar', length: 50, unique: true })
    name: string
    @ManyToOne(() => CarTypes, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'typeId', referencedColumnName: 'id' })
    type: number
}

@Entity('products')
export class Products {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ type: 'varchar' })
    name: string
    @Column({ type: 'varchar' })
    description: string
    @Column({ type: 'json', nullable: true })
    image: string
    @Column({ type: 'integer' })
    price: number
    @Column({ type: 'integer' })
    quantity: number
    @Column({ type: 'integer' })
    available_quantity: number

    @ManyToOne(() => Users, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'userId', referencedColumnName: 'id' })
    user: string

    @ManyToOne(() => Brands, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'brandId', referencedColumnName: 'id' })
    brand: number
}