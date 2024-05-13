package org.taskflow.TaskFlow.services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.taskflow.TaskFlow.repositories.MarkRepository;

@Service
@Slf4j
@RequiredArgsConstructor
public class MarkService {

    private final MarkRepository markRepository;


}
