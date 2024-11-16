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
}