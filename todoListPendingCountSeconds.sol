// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract TodoList {
    struct TodoItem {
        string content;
        bool completed;
        uint256 moveTime;
    }

    TodoItem[] public todos;
    TodoItem[] public todoCompleted;
    TodoItem[] public todoPending;

    uint256 private constant WAITING_PERIOD = 60; // waiting period in seconds

    constructor() {}

    function addTodo(string memory content) external {
        todos.push(TodoItem(content, false, 0));
    }

    function setCompleted(uint256 index) external {
        TodoItem memory completedTodo = todos[index];
        completedTodo.completed = true;
        completedTodo.moveTime = block.timestamp;

        for (uint256 i = index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        delete todos[todos.length - 1];
        todos.pop();

        todoCompleted.push(completedTodo);
    }

    function setPending(uint256 index) external {
        TodoItem memory pendingTodo = todos[index];
        pendingTodo.completed = false;
        pendingTodo.moveTime = block.timestamp;

        for (uint256 i = index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        delete todos[todos.length - 1];
        todos.pop();

        todoPending.push(pendingTodo);
    }

    function getTodo(uint256 index) external view returns (string memory) {
        return todos[index].content;
    }

    function deleteTodo(uint256 index) external {
        for (uint256 i = index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        delete todos[todos.length - 1];
        todos.pop();
    }

    function getCompleted(uint256 index) external view returns (string memory) {
        return todoCompleted[index].content;
    }

    function getPending(uint256 index) external view returns (string memory) {
        return todoPending[index].content;
    }

    function getAllTodo() external view returns (string[] memory) {
        string[] memory contentList = new string[](todos.length);
        for (uint256 i = 0; i < todos.length; i++) {
            contentList[i] = todos[i].content;
        }
        return contentList;
    }

    function getAllCompleted() external view returns (string[] memory) {
        string[] memory contentList = new string[](todoCompleted.length);
        for (uint256 i = 0; i < todoCompleted.length; i++) {
            contentList[i] = todoCompleted[i].content;
        }
        return contentList;
    }

    function getAllPending() external view returns (string[] memory) {
        string[] memory contentList = new string[](todoPending.length);
        for (uint256 i = 0; i < todoPending.length; i++) {
            contentList[i] = todoPending[i].content;
        }
        return contentList;
    }

    function movePendingToTodoList(uint256 index) external {
        require(index < todoPending.length, "Invalid index");
        TodoItem memory pendingTodo = todoPending[index];
        require(
            block.timestamp - pendingTodo.moveTime < WAITING_PERIOD,
            "Cannot move back to todo list"
        );

        for (uint256 i = index; i < todoPending.length - 1; i++) {
            todoPending[i] = todoPending[i + 1];
        }
        delete todoPending[todoPending.length - 1];
        todoPending.pop();

        todos.push(pendingTodo);
    }
}
