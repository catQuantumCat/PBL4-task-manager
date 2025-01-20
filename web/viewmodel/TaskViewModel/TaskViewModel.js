import TaskView from "../../view/TaskLogicView/TaskView.js";

export default class TaskViewModel {
    async fetchAndUpdateTasks(tasks) {
        try {
            this.updateView(tasks);
        } catch (error) {
            console.error('Error updating view:', error);
        }
    }

    updateView(tasks) {
        TaskView.renderTasks(tasks);
    }
}
