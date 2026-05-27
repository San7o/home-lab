Local LLMs
==========

Some notes on installing LLMs locally.

Ollama
------

Ollama_ is a simple frontend for llama.cpp_ which is an inference engine. You
can download models from the ollama repository with:

.. _Ollama: https://github.com/ollama/ollama
.. _llama.cpp: https://github.com/ggml-org/llama.cpp

.. code-block:: bash

    ollama pull ministral-3:3b

Additionally, all llama.cpp compatible models also work with ollama. This means
that you can download a `.gguf` model from a different repository like
huggingface_ and create a `Modelfile` like this:

.. _huggingface: https://huggingface.co/

.. code-block:: dockerfile

    FROM ./LFM2.5-1.2B-Instruct-Q4_K_M.gguf
    
    PARAMETER temperature 0.15
    PARAMETER top_p 0.9
    PARAMETER stop "</s>"
    
    SYSTEM """
    You are a helpful assistant.
    """

A more elaborated Modelfile would look like this:

.. code-block:: dockerfile

    FROM ./LFM2.5-1.2B-Instruct-Q8_0.gguf
    
    PARAMETER temperature 0.15
    PARAMETER top_p 0.9
    PARAMETER stop "</s>"
    
    TEMPLATE """{{- $lastUserIndex := -1 }}
    {{- $hasSystemPrompt := false }}
    {{- range $index, $_ := .Messages }}
    {{- if eq .Role "user" }}{{ $lastUserIndex = $index }}{{ end }}
    {{- if eq .Role "system" }}{{ $hasSystemPrompt = true }}{{ end }}
    {{- end }}
    {{- if not $hasSystemPrompt }}[SYSTEM_PROMPT]You are Ministral-3-3B-Instruct-2512, a Large Language Model (LLM) created by Mistral AI, a French startup headquartered in Paris.
    You power an AI assistant called Le Chat.
    Your knowledge base was last updated on 2023-10-01.
    The current date is {{ currentDate }}.
    
    When you are not sure about some information, or when the user's request requires up-to-date or specific data beyond your knowledge base, clearly state that you do not have the information and avoid making anything up.
    
    If the user's question is not clear, ambiguous, or does not provide enough context for you to accurately answer, do not answer it right away. Instead, ask the user to clarify their request (e.g. "What are some good restaurants around me?" → "Where are you?" or "When is the next flight to Tokyo?" → "Where do you travel from?").
    
    You are always very attentive to dates. You try to resolve relative dates (e.g. "yesterday" is {{ yesterdayDate }}), and when asked about information at specific dates, you discard information that applies to a different date.
    
    You follow these instructions in all languages, and always respond to the user in the language they use or request.
    
    # WEB BROWSING LIMITATIONS
    
    You cannot perform any web search or access the internet, including opening URLs or links. If the user expects you to do so, clearly explain this limitation and ask them to paste the relevant content directly into the chat.
    
    # MULTI-MODAL INSTRUCTIONS
    
    You can read images, but you cannot generate images.
    You cannot read, transcribe, or process audio files or videos.[/SYSTEM_PROMPT]
    {{- end }}
    {{- range $index, $_ := .Messages }}
    {{- if eq .Role "system" }}[SYSTEM_PROMPT]{{ .Content }}[/SYSTEM_PROMPT]
    {{- else if eq .Role "user" }}[INST]{{ .Content }}[/INST]
    {{- else if eq .Role "assistant" }}
    {{- if .Content }}{{ .Content }}
    {{- if not (eq (len (slice $.Messages $index)) 1) }}</s>
    {{- end }}
    {{- end }}
    {{- end }}
    {{- end }}

And load it with:

.. code-block:: bash

    ollama create mymodel:latest -f ./Modelfile

To read the modelfile of a model you downloaded from the ollama
repository, run:

.. code-block:: bash

    ollama show --modelfile ministral-3:3b

Flowise
-------

You can use flowise_ to build AI agents.

.. _flowise: https://github.com/FlowiseAI/Flowise
