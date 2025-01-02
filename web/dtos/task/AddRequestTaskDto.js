export default class AddRequestTaskDto {
    constructor(name, description, priority, createTime, deadTime, status)
    {
        this.name = name,
        this.description = description,
        this.priority = priority,
        this.createTime = createTime,
        this.deadTime = deadTime,
        this.status = status
    };
}