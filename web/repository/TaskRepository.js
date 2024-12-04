import TaskDto from "../dtos/task/TaskDto.js";

export default class TaskRepository {
    async getAllTask(username) {
        return fetch('http://localhost:5245/backend/mission/GetByUsername', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(username)
        })
        .then(response => {
            if(!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            return data.map(task => new TaskDto(
                task.id,
                task.name,
                task.description,
                task.priority,
                task.createTime,
                task.deadTime,
                task.status
            ));
        });
    }

    async updateTask(id, taskModel) {
        return fetch(`http://localhost:5245/backend/mission/updateAdmin/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(taskModel)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        });
    }

    async deleteTask(id) {
        return fetch(`http://localhost:5245/backend/mission/deleteAdmin/${id}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            },
        })
        .then(response => {
            if(!response.ok) {
                throw new Error('Network response is not ok');
            }
            alert("Xoa task thanh cong");
        })
    }

    async addTask(taskModel, username) {
        console.log(JSON.stringify(taskModel));
        return fetch(`http://localhost:5245/backend/mission/createAdmin?username=${username}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(taskModel)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        });
    }
}