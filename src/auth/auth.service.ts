import {
    ConflictException,
    Injectable,
    InternalServerErrorException,
    UnauthorizedException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import LoginDto from './dto/login.dto';
import SignUpDto from './dto/signup.dto';
import { UserRole, Users } from 'src/entity/user.entity';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(Users) private usersRepository: Repository<Users>,
        private jwt: JwtService,
    ) { }

    async login(loginDto: LoginDto) {
        const { email, password } = loginDto;
        const user = await this.usersRepository.findOne({
            where: { email },
            select: {
                id: true,
                email: true,
                password: true,
                phone_number: true,
                username: true
            }
        });

        if (!user || user.password !== password) {
            throw new UnauthorizedException('Email or password incorect');
        } else {
            const payload = { email: email };
            const accessToken = await this.jwt.signAsync(payload, {
                expiresIn: '1d',
            });
            return { accessToken, user };
        }
    }

    async signup(signupDto: SignUpDto, role: UserRole) {
        const { email, password, username, phone_number } = signupDto;
        if (!!(await this.usersRepository.count({ where: { email: email } })))
            throw new ConflictException(
                'This email address is already used. Try a different email address.',
            );
        try {
            await this.usersRepository.save({
                email: email,
                password: password,
                username: username,
                phone_number: phone_number,
                isBanned: false,
                role: role
            });
            return {
                message: 'Create account successfully',
            };
        } catch (error) {
            throw new InternalServerErrorException();
        }
    }
}
