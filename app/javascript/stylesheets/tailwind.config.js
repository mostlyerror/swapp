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
				black: '2px solid black',
			}
		},
	},
	variants: {
		extend: {},
	},
	plugins: [],
}
