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
			outline: {
				black: ['2px solid black', '2px'],
				gray: ['2px solid #d3d3d3', '2px'],
			}
		},
	},
	variants: {
		extend: {},
	},
	plugins: [],
}
