// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "remix_tests.sol";
import "../todoListPendingCountSeconds.sol";

contract TodoListTest {
    TodoList todoList;

    function beforeEach() public {
        todoList = new TodoList();
    }

    function testAddTodo() public {
        string memory todo = "buy milk";
        todoList.addTodo(todo);

        TodoList.TodoItem memory addedTodo = todoList.getTodo(0);
        Assert.equal(addedTodo.name, todo, "Todo name should be 'buy milk'");
        Assert.equal(addedTodo.completed, false, "Todo should be marked as incomplete");
        Assert.equal(addedTodo.isPending, false, "Todo should not be marked as pending");
        Assert.equal(addedTodo.pendingTime, 0, "Todo pending time should be zero");
        Assert.equal(addedTodo.createdTime, block.timestamp, "Todo creation time should be block.timestamp");
    }

    function testSetCompleted() public {
        string memory todo = "buy milk";
        todoList.addTodo(todo);
        todoList.setCompleted(0);

        TodoList.TodoItem memory completedTodo = todoList.getCompleted(0);
        Assert.equal(completedTodo.name, todo, "Completed todo name should be 'buy milk'");
        Assert.equal(completedTodo.completed, true, "Completed todo should be marked as complete");
        Assert.equal(completedTodo.isPending, false, "Completed todo should not be marked as pending");
        Assert.equal(completedTodo.pendingTime, 0, "Completed todo pending time should be zero");
        Assert.equal(completedTodo.createdTime, block.timestamp, "Completed todo creation time should be block.timestamp");

        uint256 todoCount = todoList.getTodoCount();
        Assert.equal(todoCount, 0, "Todo count should be zero after setting todo as completed");
    }

    function testSetPending() public {
        string memory todo = "buy milk";
        todoList.addTodo(todo);
        todoList.setPending(0);

        TodoList.TodoItem memory pendingTodo = todoList.getPending(0);
        Assert.equal(pendingTodo.name, todo, "Pending todo name should be 'buy milk'");
        Assert.equal(pendingTodo.completed, false, "Pending todo should be marked as incomplete");
        Assert.equal(pendingTodo.isPending, true, "Pending todo should be marked as pending");
        Assert.equal(pendingTodo.pendingTime, block.timestamp, "Pending todo pending time should be block.timestamp");
        Assert.equal(pendingTodo.createdTime, block.timestamp, "Pending todo creation time should be block.timestamp");

        uint256 todoCount = todoList.getTodoCount();
        Assert.equal(todoCount, 0, "Todo count should be zero after setting todo as pending");
    }

    function testDeleteTodo() public {
        string memory todo = "buy milk";
        todoList.addTodo(todo);
        todoList.deleteTodo(0);

        uint256 todoCount = todoList.getTodoCount();
        Assert.equal(todoCount, 0, "Todo count should be zero after deleting the only todo");
    }

    function testClearCompleted() public {
        string memory todo = "buy milk";
        todoList.addTodo(todo);todoList.setCompleted(0);
        todoList.clearCompleted();

        uint256 completedCount = todoList.getCompletedCount();
        Assert.equal(completedCount, 0, "Completed todo count should be zero after clearing completed todos");
    }

    function testGetAllTodo() public {
        string memory todo1 = "buy milk";
        string memory todo2 = "walk the dog";
        todoList.addTodo(todo1);
        todoList.addTodo(todo2);

        TodoList.TodoItem[] memory todos = todoList.getAllTodo();
        Assert.equal(todos.length, 2, "Todo count should be 2");
        Assert.equal(todos[0].name, todo1, "First todo should be 'buy milk'");
        Assert.equal(todos[1].name, todo2, "Second todo should be 'walk the dog'");
    }

    function testGetAllCompleted() public {
        string memory todo1 = "buy milk";
        string memory todo2 = "walk the dog";
        todoList.addTodo(todo1);
        todoList.addTodo(todo2);
        todoList.setCompleted(0);

        TodoList.TodoItem[] memory completedTodos = todoList.getAllCompleted();
        Assert.equal(completedTodos.length, 1, "Completed todo count should be 1");
        Assert.equal(completedTodos[0].name, todo1, "Completed todo should be 'buy milk'");
    }

    function testGetAllPending() public {
        string memory todo1 = "buy milk";
        string memory todo2 = "walk the dog";
        todoList.addTodo(todo1);
        todoList.addTodo(todo2);
        todoList.setPending(0);

        TodoList.TodoItem[] memory pendingTodos = todoList.getAllPending();
        Assert.equal(pendingTodos.length, 1, "Pending todo count should be 1");
        Assert.equal(pendingTodos[0].name, todo1, "Pending todo should be 'buy milk'");
    }

    function testGetTodoCount() public {
        string memory todo1 = "buy milk";
        string memory todo2 = "walk the dog";
        todoList.addTodo(todo1);
        todoList.addTodo(todo2);

        uint256 todoCount = todoList.getTodoCount();
        Assert.equal(todoCount, 2, "Todo count should be 2");
    }

    function testGetCompletedCount() public {
        string memory todo1 = "buy milk";
        string memory todo2 = "walk the dog";
        todoList.addTodo(todo1);
        todoList.addTodo(todo2);
        todoList.setCompleted(0);

        uint256 completedCount = todoList.getCompletedCount();
        Assert.equal(completedCount, 1, "Completed todo count should be 1");
    }

    function testGetPendingCount() public {
        string memory todo1 = "buy milk";
        string memory todo2 = "walk the dog";
        todoList.addTodo(todo1);
        todoList.addTodo(todo2);
        todoList.setPending(0);

        uint256 pendingCount = todoList.getPendingCount();
        Assert.equal(pendingCount, 1, "Pending todo count should be 1");
    }
}
