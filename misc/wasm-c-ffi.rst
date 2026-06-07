Wasm-C FFI
==========

main.c:

.. code-block:: c

    // Example function
    int add(int a, int b)
    {
      return a + b;
    }

    // This function is defined in javascript
    extern void print(const char* str);

    int main(void)
    {
      print("Hello, World!");
      return 0;
    }

Compilation:

.. code-block:: bash

    clang --target=wasm32 -nodefaultlibs -nostdlib -Wl,--no-entry -Wl,--export-all -Wl,--allow-undefined -Wl,--initial-memory=131072 -o main.wasm main.c

index.js:

.. code-block:: c

    // Helper function to get a string from a pointer in memory
    function getString(ptr, memory) {
        const bytes = new Uint8Array(memory.buffer, ptr);
        let len = 0;
        while (bytes[len] !== 0) len++;
        return new TextDecoder().decode(bytes.slice(0, len));
    }

    const importObject = {
        env: {
            // Provide functions that can be called from C
            print: (ptr) => {
                const str = getString(ptr, wasmInstance.exports.memory);
                console.log("From C: ", str);
            },
        },
    }

    let wasmInstance;
    WebAssembly.instantiateStreaming(fetch("main.wasm"), importObject).then(
        (obj) => {

            wasmInstance = obj.instance;

            // Call a C function
            const res = wasmInstance.exports.add(1, 2);
            console.log("1 + 2 = ", res);

            // Call main
            wasmInstance.exports.main();
        }
    );

index.html:

.. code-block:: c

    <!DOCTYPE html>
    <html lang="en">
      
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>My Website</title>
        <link rel="stylesheet" href="./style.css">
        <link rel="icon" href="./favicon.ico" type="image/x-icon">
      </head>
      
      <body>
        <main>
          <h1>Welcome to My Website</h1>  
        </main>
        <script src="index.js"></script>
      </body>
      
    </html>

Run a server:

.. code-block:: bash

    python3 -m http.server
