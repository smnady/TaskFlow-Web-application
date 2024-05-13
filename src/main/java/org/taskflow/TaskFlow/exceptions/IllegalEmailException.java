package org.taskflow.TaskFlow.exceptions;

public class IllegalEmailException extends Exception {
    public IllegalEmailException() {
        super("Аккаунт с таким email уже существует.");
    }
}
