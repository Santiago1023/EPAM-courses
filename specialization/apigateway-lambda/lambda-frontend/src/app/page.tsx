"use client";
import axios from "axios";

export default function Home() {
  async function handleDictionary() {
    try {
      const payload = {
        d: { Apple: "A fruit that grows on trees", Car: "A vehicle with four wheels" },
        l: ["Apple", "Banana"]
      };

      const response = await axios.post(
        "https://hnmtuqel3e.execute-api.us-east-1.amazonaws.com/test/dictionary-resource",
        payload, // Send the dictionary as the request body
        {
          headers: { "Content-Type": "application/json" }, // Ensure JSON format
        }
      );

      console.log(response.data);
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <div className="flex justify-center items-center">
      <button onClick={handleDictionary} className="bg-black text-white rounded-xl p-2">
        traer informacion
      </button>
    </div>
  );
}
