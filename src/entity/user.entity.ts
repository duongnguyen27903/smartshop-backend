import { Column, CreateDateColumn, Entity, Generated, JoinColumn, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";

export enum UserRole {
    admin = "admin",
    user = "user"
}

export enum Gender {
    male = "male",
    female = "female",
    unknown = "unknown"
}

@Entity({ name: 'users' })
export class Users {
    @PrimaryGeneratedColumn('uuid')
    id: string
    @Column({ nullable: false, unique: true, type: 'varchar', length: 50 })
    email: string
    @Column({ type: 'varchar', length: 30 })
    password: string
    @Column({ type: 'varchar', length: 20 })
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

@Entity({ name: 'accounts' })
export class Accounts {
    @PrimaryGeneratedColumn('increment')
    id: number
    @Column({ unique: true, type: 'varchar' })
    account_number: string
    @Column({ type: 'bigint' })
    account_balance: number
    @Column({ default: true })
    isActive: boolean
    @OneToOne(() => Users, { nullable: false, onDelete: 'CASCADE', onUpdate: 'CASCADE', cascade: true })
    @JoinColumn({ name: 'userId', referencedColumnName: 'id' })
    user: Users
}

export enum Action {
    sell = 'sell',
    buy = 'bought'
}

@Entity({ name: 'transaction_histories' })
export class TransactionHistories {
    @PrimaryGeneratedColumn("increment")
    id: number
    @Column({ type: 'enum', enum: Action, nullable: false })
    action: Action

}