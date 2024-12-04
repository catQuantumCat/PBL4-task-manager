import AddRequestTaskDto from "../../dtos/task/AddRequestTaskDto.js";
import TaskRepository from "../../repository/TaskRepository.js";
const urlParams = new URLSearchParams(window.location.search);
const username = urlParams.get('username').replace(/'/g, '');

const taskRepo = new TaskRepository();


document.getElementById("submit-btn").onclick = function() {
    const taskModel = new AddRequestTaskDto(document.getElementById("name").value,document.getElementById("description").value,document.getElementById("priority").value,document.getElementById("createTime").value,document.getElementById("deadTime").value,JSON.parse(document.getElementById("status").value));
    taskRepo.addTask(taskModel, username)
    .then(data => {
        console.log('Success:', data);
        alert("Them Task thanh cong");
        parent.frames['content'].location.href = "javascript:history.back()";
    })
    .catch((error) => {
        console.error('Error:', error);
    }); 
}