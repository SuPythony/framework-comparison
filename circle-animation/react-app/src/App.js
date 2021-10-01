import React, { useState } from "react";
import "./App.css";

function App() {
    const [time, setTime] = useState(500);
    const [shape, setShape] = useState(true);
    const [color, setColor] = useState(false);
    const [colorToChange, setCTC] = useState("#ff0000");
    let [shapeToChange, setSTC] = useState("square");
    let [shapeToChangeWidth, setSTCW] = useState("100px");
    let [shapeToChangeHeight, setSTCH] = useState("100px");
    let colors = [
        { name: "red", hex: "#ff0000" },
        { name: "yellow", hex: "	#ffff00" },
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
    document.title = "React Circle Animation";
    return (
        <div id="container" style={{ "--color-to-change": colorToChange }}>
            <div
                className={`animated ${shape ? "shape" : ""} ${
                    color ? "color" : ""
                }`}
                style={{
                    transition: `${time}ms ease`,
                    "--width-to-change": shapeToChangeWidth,
                    "--height-to-change": shapeToChangeHeight,
                }}
            />
            <label htmlFor="time">Animation Time:</label>
            <div>
                <input
                    id="time"
                    type="range"
                    min="0"
                    max="2000"
                    step="10"
                    value={time}
                    onChange={(e) => setTime(e.target.value)}
                />
                <input
                    type="number"
                    min="0"
                    max="2000"
                    step="10"
                    value={time}
                    onChange={(e) => setTime(e.target.value)}
                />
            </div>

            <div>
                <button
                    className={`${shape && !color ? "selected" : ""}`}
                    onClick={() => {
                        setShape(true);
                        setColor(false);
                    }}
                >
                    Change Shape
                </button>
                <button
                    className={`${color && !shape ? "selected" : ""}`}
                    onClick={() => {
                        setShape(false);
                        setColor(true);
                    }}
                >
                    Change Color
                </button>
                <button
                    className={`${shape && color ? "selected" : ""}`}
                    onClick={() => {
                        setShape(true);
                        setColor(true);
                    }}
                >
                    Both
                </button>
            </div>

            {!(!shape && color) ? (
                <>
                    <p>Change to Shape</p>
                    <div style={{ display: "flex", gap: "10px" }}>
                        {shapes.map((shape) => (
                            <button
                                key={shape.name}
                                className={
                                    shape.name === shapeToChange
                                        ? "selected"
                                        : ""
                                }
                                onClick={() => {
                                    setSTC(shape.name);
                                    setSTCW(shape.width);
                                    setSTCH(shape.height || "100px");
                                }}
                            >
                                {shape.name}
                            </button>
                        ))}
                    </div>
                </>
            ) : null}

            {!(shape && !color) ? (
                <>
                    <p>Change to Color</p>
                    <div
                        style={{
                            display: "flex",
                            gap: "10px",
                            "align-items": "center",
                        }}
                    >
                        {colors.map((color) => (
                            <button
                                key={color.name}
                                className={
                                    color.hexe === colorToChange
                                        ? "selected"
                                        : ""
                                }
                                onClick={() => {
                                    setCTC(color.hex);
                                }}
                            >
                                {color.name}
                            </button>
                        ))}
                        <input
                            type="color"
                            id="color-picker"
                            value={colorToChange}
                            onChange={(e) => setCTC(e.target.value)}
                        />
                    </div>
                </>
            ) : null}
        </div>
    );
}

export default App;
