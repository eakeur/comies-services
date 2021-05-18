export abstract class FriendlyError {
    code: string; message: string; description?: string; comiesDomain: boolean = true;

    constructor(code: string, message: string){
        this.code = code; this.message = message;
    }
}

export class ForbiddenError extends FriendlyError {

    constructor(description?: string){
        super('FORBIDDEN', 'Ops! Você não pode realizar essa ação :(');
        this.description = description;
    }
}

export class UnauthorizedError extends FriendlyError {

    constructor(description?: string){
        super('UNAUTHORIZED', 'Ops! Você não pode realizar essa ação :(');
        this.description = description;
    }
} 

export class MissingInformationError extends FriendlyError {

    constructor(description?: string){
        super('UNINFORMED', 'Ei, algumas informações ficaram faltando...');
        this.description = description;
    }
}

export class InvalidInformationError extends FriendlyError {

    constructor(description?: string){
        super('INVALID', 'Ei, algumas informações que você nos passou são inválidas...');
        this.description = description;
    }
}