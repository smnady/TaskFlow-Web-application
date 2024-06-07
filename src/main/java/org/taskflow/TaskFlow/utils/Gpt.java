package org.taskflow.TaskFlow.utils;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.json.JSONObject;

public class Gpt {
    private static final String url = "https://llm.api.cloud.yandex.net/foundationModels/v1/completion";
    private static final String API_KEY = "YOUR_OWN_API_KEY";
    private static final String CATALOG_ID = "YOUR_OWN_CATALOG_ID";
    private static final String MODEL_URI = String.format("gpt://%s/yandexgpt/latest", CATALOG_ID);
    private static final String DESCRIPTION_CONTEXT =
            "Напиши возможное описание и возможные подзадачи для сдедующей задачи без лишних вводных слов:";

    public static String generateDescription(String message) throws UnirestException {
        JSONObject requestBody = new JSONObject();
        requestBody.put("modelUri", MODEL_URI);

        JSONObject completionOptions = new JSONObject();
        completionOptions.put("stream", false);
        completionOptions.put("temperature", 0.6);
        completionOptions.put("maxTokens", "700");

        requestBody.put("completionOptions", completionOptions);

        JSONObject userMessage = new JSONObject();
        userMessage.put("role", "user");
        userMessage.put("text", DESCRIPTION_CONTEXT + message);

        requestBody.append("messages", userMessage);

        HttpResponse<JsonNode> jsonResponse = Unirest.post(url)
                .header("Content-Type", "application/json")
                .header("Authorization", "Api-Key " + API_KEY)
                .header("x-folder-id", CATALOG_ID)
                .body(requestBody)
                .asJson();

        String text = jsonResponse.getBody().getObject()
                .getJSONObject("result")
                .getJSONArray("alternatives")
                .getJSONObject(0)
                .getJSONObject("message").getString("text");

        return text.replaceAll("[*]", "");
    }

}
