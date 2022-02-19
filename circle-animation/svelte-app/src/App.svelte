<script>
    let time = 500;
    let shape = true;
    let color = false;
    let colorToChange = "#ff0000";
    let shapeToChange = "square";
    let shapeToChangeWidth = "100px";
    let shapeToChangeHeight = "100px";
    let colors = [
        { name: "red", hex: "#ff0000" },
        { name: "yellow", hex: "#ffff00" },
        { name: "pink", hex: "#ffc0cb" },
        { name: "orange", hex: "#ffa500" },
        { name: "purple", hex: "#800080" },
        { name: "cyan", hex: "#00ffff" },
        { name: "chocolate", hex: "#D2691E" },
    ];
    let shapes = [
        { name: "small square", width: "50px", height: "50px" },
        { name: "square", width: "100px" },
        { name: "rectangle", width: "150px" },
        { name: "elongated rectangle", width: "250px" },
        { name: "vertical rectangle", width: "50px" },
        { name: "full rectangle", width: "100%" },
    ];
</script>

<svelte:head>
    <title>Svelte Circle Animation</title>
</svelte:head>

<div id="container" style="--color-to-change: {colorToChange}">
    <div
        class="animated"
        style="transition: {time}ms ease; --width-to-change: {shapeToChangeWidth}; --height-to-change: {shapeToChangeHeight}"
        class:shape
        class:color
    />
    <label for="time">Animation Time:</label>
    <div>
        <input
            id="time"
            type="range"
            min="0"
            max="2000"
            step="10"
            bind:value={time}
        />
        <input type="number" min="0" max="2000" step="10" bind:value={time} />
    </div>

    <div>
        <button
            class:selected={shape && !color}
            on:click={() => {
                shape = true;
                color = false;
            }}
        >
            Change shape
        </button>
        <button
            class:selected={color && !shape}
            on:click={() => {
                shape = false;
                color = true;
            }}
        >
            Change color
        </button>
        <button
            class:selected={shape && color}
            on:click={() => {
                shape = true;
                color = true;
            }}
        >
            Both
        </button>
    </div>

    {#if !(!shape && color)}
        <p>Change to Shape</p>
        <div style="display: flex; gap: 10px;">
            {#each shapes as shape (shape.name)}
                <button
                    class:selected={shape.name === shapeToChange}
                    on:click={() => {
                        shapeToChange = shape.name;
                        shapeToChangeWidth = shape.width;
                        shapeToChangeHeight = shape.height || "100px";
                    }}>{shape.name}</button
                >
            {/each}
        </div>
    {/if}

    {#if !(shape && !color)}
        <p>Change to Color</p>
        <div style="display: flex; gap: 10px; align-items: center;">
            {#each colors as color (color.name)}
                <button
                    class:selected={color.hex === colorToChange}
                    on:click={() => {
                        colorToChange = color.hex;
                    }}>{color.name}</button
                >
            {/each}
            <input type="color" id="color-picker" bind:value={colorToChange} />
        </div>
    {/if}
</div>

<style>
    #container {
        display: flex;
        flex-direction: column;
        align-items: center;
        border: 5px solid var(--color-to-change);
        border-radius: 10px;
        padding: 10px;
    }
    .animated {
        width: 100px;
        height: 100px;
        margin: auto;
        background-color: blue;
        border-radius: 50px;
    }
    .selected {
        background-color: gold;
    }
    .shape:hover {
        border-radius: 0px;
        width: var(--width-to-change);
        height: var(--height-to-change);
    }
    .color:hover {
        background-color: var(--color-to-change);
    }
    button {
        border-radius: 10px;
        background-color: red;
        color: white;
        text-transform: capitalize;
        padding: 5px;
    }
    button:not(.selected):hover {
        opacity: 0.5;
    }
    p,
    label {
        font-weight: bold;
        font-size: 20px;
    }
    #color-picker {
        background-color: var(--color-to-change);
    }
    #color-picker::-webkit-color-swatch {
        display: none;
    }
</style>
