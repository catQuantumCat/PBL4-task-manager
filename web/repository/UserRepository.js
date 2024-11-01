import UserDto from "../dtos/user/UserDto.js";

export default class UserRepository {

    async getAllUsers() {
        try {
            const response = await fetch('http://localhost:5245/backend/account');
            const usersData = await response.json();

            const users = usersData.map(user => new UserDto(user));

            return users;
        } catch (error) {
            console.error('Error fetching users:', error);
            throw error;
        }
    }

    async addUser(user) {
        return fetch('http://localhost:5245/backend/account/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(user)
        })
        .then(response => {
            if(!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        });
    }

    async editUser(user) {
        return fetch('http://localhost:5245/backend/account/editUser', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(user) 
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        });
    }

    async deleteUser(user) {
        return fetch('http://localhost:5245/backend/account/delete', {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(user)
        })
        .then(response => {
            if(!response.ok) {
                throw new Error('Network response is not ok');
            }
            alert("Xoa nguoi dung thanh cong");
        })
    }
}