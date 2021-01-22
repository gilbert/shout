//
// Export colors from from https://palettte.app
// You can copy/paste the output to re-edit
//
const exportedColors = [
  {
    "paletteName": "Primary",
    "swatches": [
      {
        "name": "blue-900",
        "color": "0A4A71"
      },
      {
        "name": "blue-800",
        "color": "116FA2"
      },
      {
        "name": "blue-700",
        "color": "1B87C1"
      },
      {
        "name": "blue-600",
        "color": "2B9CDA"
      },
      {
        "name": "blue-500",
        "color": "32A4E2"
      },
      {
        "name": "blue-400",
        "color": "55BAF1"
      },
      {
        "name": "blue-300",
        "color": "7ECAF7"
      },
      {
        "name": "blue-200",
        "color": "C0E0F8"
      },
      {
        "name": "blue-100",
        "color": "EFF6FF"
      },
      {
        "name": "blue-50",
        "color": "F6FAFE"
      }
    ]
  }
]


module.exports = {
  theme: {
    extend: {
      colors: exportedColors.map(c => c.swatches).reduce((a,b) => a.concat(b), []).reduce((out, row) => {
        const [colorName, shade] = row.name.split('-')
        out[colorName] = out[colorName] || {}
        out[colorName][shade] = `#${row.color}`
        return out
      }, {}),

      fontSize: {
        '7xl': '5rem',
        '8xl': '6rem',
      }
    },
  },

  // See https://tailwindcss.com/docs/configuring-variants/#app
  variants: {},

  plugins: [
    require('@tailwindcss/forms')
  ],

  // See https://tailwindcss.com/docs/controlling-file-size/
  purge: [
    './app/helpers/**/*.rb',
    './app/views/**/*.html.erb',
  ],
}
