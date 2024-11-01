export default class AddRequestUserDto {
    constructor({username, email, password}) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
};