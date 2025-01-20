import TaskRepository from "../../repository/TaskRepository.js";
import UpdateRequestTaskDto from "../../dtos/task/UpdateRequestTaskDto.js";

const urlParams = new URLSearchParams(window.location.search);
const taskId = urlParams.get('id').replace(/'/g, '');
const username = urlParams.get('username').replace(/'/g, '');

const taskRepo = new TaskRepository();

window.fillTask = async() => {
    const allTask = await taskRepo.getAllTask(username);
    const editTask = allTask.find(x => x.id == taskId);
    document.getElementById("id").value = editTask.id;
    document.getElementById("name").value = editTask.name;
    document.getElementById("description").value = editTask.description;
    document.getElementById("priority").value = editTask.priority;
    document.getElementById("createTime").value = editTask.createTime;
    document.getElementById("deadTime").value = editTask.deadTime;
    document.getElementById("status").value = editTask.status;
}

document.getElementById("submit-btn").onclick = function () {
    const taskModel = new UpdateRequestTaskDto(document.getElementById("name").value,document.getElementById("description").value,document.getElementById("priority").value,document.getElementById("deadTime").value,JSON.parse(document.getElementById("status").value));
    taskRepo.updateTask(taskId, taskModel)
    .then(data => {
        console.log('Success:', data);
        alert("Sua Task thanh cong");
        parent.frames['content'].location.href = "javascript:history.back()";
    })
    .catch((error) => {
        console.error('Error:', error);
    }); 
    
}






