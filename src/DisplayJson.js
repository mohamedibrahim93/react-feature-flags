import React from "react";

const DisplayJson = ({ title, jsonData }) => {
  return (
    <div>
      <h1>{title}</h1>
      {/* Display JSON in a preformatted block */}
      <pre
        style={{
          background: "#000",
          padding: "20px",
          borderRadius: "5px",
          textAlign: "left",
          fontSize: "large",
          fontWeight: "bold",
          lineHeight: "30px",
        }}
      >
        {JSON.stringify(jsonData, null, 2)}
      </pre>
    </div>
  );
};

export default DisplayJson;
