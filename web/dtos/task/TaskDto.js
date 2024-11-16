export default class TaskDto {
    constructor(id, name, description, priority, createTime, deadTime, status)
    {
        this.id = id,
        this.name = name,
        this.description = description,
        this.priority = priority,
        this.createTime = createTime,
        this.deadTime = deadTime,
        this.status = status
    };
}