import { Check, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn, Unique, UpdateDateColumn } from "typeorm";
import { Products } from "./shop.entity";

export enum UserRole {
    admin = "admin",
    user = "user"
}

export enum Gender {
    male = "male",
    female = "female",
    unknown = "unknown"
}

export enum Action {
    deposit = 'deposit',
    buy = 'buy',
    sell = 'sell'
}

@Entity({ name: 'users' })
export class Users {
    @PrimaryGeneratedColumn('uuid')
    id: string

    @Column({ nullable: false, unique: true, type: 'varchar', length: 50 })
    email: string

    @Column({ type: 'varchar', length: 30 })
    password: string

    @Column({ type: 'varchar', length: 20, unique: true })
    username: string

    @Column({ type: "boolean", default: false })
    isBanned: boolean

    @Column({ nullable: true, type: "varchar", length: 30 })
    phone_number: string

    @Column({
        type: "enum",
        enum: UserRole,
        default: UserRole.user
    })
    role: UserRole

    @CreateDateColumn()
    createAt: Date

    @UpdateDateColumn()
    updateAt: Date
}

@Entity({ name: 'profiles' })
export class Profiles {
    @PrimaryGeneratedColumn("increment")
    id: number

    @Column({ nullable: true, length: 20 })
    first_name: string

    @Column({ nullable: true, length: 20 })
    last_name: string

    @Column({ nullable: true, length: 30 })
    birthday: string

    @Column({ nullable: true, type: 'enum', enum: Gender })
    gender: Gender

    @Column({ nullable: true, length: 100 })
    address: string

    @OneToOne(() => Users, { cascade: true, nullable: false, onDelete: "CASCADE", onUpdate: 'CASCADE', })
    @JoinColumn({ name: "userId", referencedColumnName: 'id' })
    user: Users
}

@Entity({ name: 'carts' })
@Unique(["userId", "productId"])
export class Carts {
    @PrimaryGeneratedColumn('increment')
    id: number

    @ManyToOne(() => Users, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'userId', referencedColumnName: 'id' })
    userId: string

    @ManyToOne(() => Products, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'productId', referencedColumnName: 'id' })
    productId: number

    @Column({ type: 'integer' })
    amount: number
}

@Entity({ name: 'accounts' })
@Check('LENGTH(TRIM(account_number)) = 12')
export class Accounts {
    @PrimaryGeneratedColumn('increment')
    id: number

    @Column({ unique: true, type: 'varchar', length: 12 })
    account_number: string

    @Column({ type: 'bigint', default: 0 })
    account_balance: number

    @Column({ default: true })
    isActive: boolean

    @OneToOne(() => Users, { nullable: false, onDelete: 'CASCADE', onUpdate: 'CASCADE', cascade: true })
    @JoinColumn({ name: 'userId', referencedColumnName: 'id' })
    user: Users
}

@Entity({ name: 'transaction_histories' })
@Check(` (action in ('buy','sell') and "billId" is not null and "from" is not null) or (action = 'deposit' and "billId" is null and "from" is null and amount > 0 ) `)
@Check(` "account_number" <> "from" `)
export class TransactionHistories {
    @PrimaryGeneratedColumn("increment")
    id: number

    @ManyToOne(() => Accounts, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'account_number', referencedColumnName: 'account_number' })
    account_number: string

    @Column({ type: 'enum', enum: Action, nullable: false })
    action: Action

    @Column({ type: 'varchar', length: 100, nullable: true })
    note: string

    @CreateDateColumn()
    timeAt: Date

    @Column({ type: 'bigint' })
    amount: number

    @ManyToOne(() => Accounts, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE' })
    @JoinColumn({ name: 'from', referencedColumnName: 'account_number' })
    from: string

    @ManyToOne(() => Bills, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE' })
    @JoinColumn({ name: 'billId', referencedColumnName: 'id' })
    billId: number
}

@Entity({ name: 'bills' })
export class Bills {
    @PrimaryGeneratedColumn('increment')
    id: number

    @ManyToOne(() => Accounts, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'account_number', referencedColumnName: 'account_number' })
    account_number: string

    @ManyToOne(() => Products, { cascade: true, onDelete: 'CASCADE', onUpdate: 'CASCADE', nullable: false })
    @JoinColumn({ name: 'productId', referencedColumnName: 'id' })
    productId: number

    @Column({ type: 'integer' })
    amount: number

    @Column({ type: 'bigint' })
    cost: number

    @CreateDateColumn()
    billing_date: Date
}

