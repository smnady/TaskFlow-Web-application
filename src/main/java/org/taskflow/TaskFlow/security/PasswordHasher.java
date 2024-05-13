package org.taskflow.TaskFlow.security;

import com.google.common.hash.Hashing;

import java.nio.charset.StandardCharsets;

public class PasswordHasher {
    public static String hash(String password) {
        return Hashing.sha256()
                .hashString(password, StandardCharsets.UTF_8)
                .toString();
    }
}
