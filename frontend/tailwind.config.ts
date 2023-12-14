import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      backgroundImage: {
        "hero-pattern": "url('/background.jpg')",
      },
      fontFamily: {
        body: ["Nunito Sans"],
      },
      screens: {
        xs: "465px",
      },
      boxShadow: {
        "inner-sym": "inset 0px 0px 5px 0px #f311e4",
      },
      dropShadow: {
        text: "2px 2px 2px #f311e4",
      },
      colors: {
        dark: "#522152",
        primary: "#a20397",
        accent: "#f311e4",
        accent2: "#f21b4e",
        primary2: "#b6044a",
        highlight: "#fdbdfd",
        hover: "#c86bc8",
      },
    },
  },
  plugins: [],
};
export default config;
