import {FriendlyError} from '../data';

export function ForbiddenError(description?: string) : void {
    this.code = 'FORBIDDEN'; 
    this.message = 'Ops! Você não pode realizar essa ação :(';
    if (description) this.description = description;  
}

export function UnauthorizedError(description?: string) : void {
    this.code = 'UNAUTHORIZED'; 
    this.message = 'Ops! Você não pode realizar essa ação :(';
    if (description) this.description = description;  
} 

export function MissingInformationError(description?: string) : void {
    this.code = 'UNINFORMED'; 
    this.message = 'Ei, algumas informações ficaram faltando...';
    if (description) this.description = description;   
}

export function InvalidInformationError(description?: string) : void {
    this.code = 'INVALID'; 
    this.message = 'Ei, algumas informações que você nos passou são inválidas...';
    if (description) this.description = description;   
}