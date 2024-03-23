import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Users } from "./user.entity";

@Entity('categories')
export class Categories {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ type: "varchar", length: 50, unique: true })
    name: string
}

@Entity({ name: 'sub_categories' })
export class SubCategories {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ type: 'varchar', length: 50, unique: true })
    name: string
    @ManyToOne(() => Categories, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'categoryId', referencedColumnName: 'id' })
    category: number
}

@Entity('products')
export class Products {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ type: 'varchar' })
    name: string
    @Column({ type: 'varchar' })
    description: string
    @Column({ type: 'varchar' })
    image: string
    @Column({ type: 'integer' })
    price: number
    @Column({ type: 'integer' })
    quantity: number
    @Column({ type: 'integer' })
    total: number

    @ManyToOne(() => Users, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'userId', referencedColumnName: 'id' })
    user: string

    @ManyToOne(() => Categories, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'categoryId', referencedColumnName: 'id' })
    category: number
}