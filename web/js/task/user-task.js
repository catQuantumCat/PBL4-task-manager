import TaskRepository from "../../repository/TaskRepository.js";
import TaskViewModel from "../../viewmodel/TaskViewModel/TaskViewModel.js";

const urlParams = new URLSearchParams(window.location.search);
const username = urlParams.get('username').replace(/'/g, '');
const taskRepo = new TaskRepository();
const taskViewModel = new TaskViewModel();

window.getAllTask = async() => {
    const tasks = await taskRepo.getAllTask(username);
    taskViewModel.fetchAndUpdateTasks(tasks);
}