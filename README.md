# Football Matches App

This Flutter application displays a list of upcoming football matches and provides AI-generated predictions for each match outcome.

## How to Run

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd matches
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Set up the OpenAI API Key:**
    This project uses the OpenAI API to generate match predictions. You need to provide your own API key.

    It is recommended to pass the key at runtime using the `--dart-define` flag. This avoids hardcoding the key in your source code.

    ```bash
    flutter run --dart-define=OPENAI_API_KEY=YOUR_API_KEY
    ```

    Replace `YOUR_API_KEY` with your actual OpenAI API key.

## OpenAI API Parameters

*   **Model:** `gpt-4o-mini` was chosen for its balance of cost, speed, and ability to follow instructions for formatted output.
*   **Temperature:** A low value of `0.5` is used to make the output more deterministic and focused, which is ideal for generating consistent predictions.
*   **Max Tokens:** Limited to `100` tokens to ensure the response is brief and contains only the necessary information (prediction and confidence score).
