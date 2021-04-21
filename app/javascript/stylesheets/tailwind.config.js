module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.vue",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      borderColor: {
        "gray-350": "rgb(107, 114, 128)",
      },
      fontSize: {
        "5.5xl": "3.5rem",
      },
      spacing: {
        18: "4.5rem",
        28: "7rem",
      },
      outline: {
        black: ["2px solid black", "2px"],
        gray: ["2px solid #d3d3d3", "2px"],
      },
      inset: {
        128: "32rem",
        "1/5": "20%",
        "1/8": "12.5%",
        "1/10": "10%",
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
