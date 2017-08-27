const path = require('path')

module.exports = {
  entry: './src/index.js',

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: 'index.js',
  },

  resolve: {
    extensions: ['.js', '.elm']
  },

  module: {
    rules: [
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        loader:  'elm-webpack-loader?verbose=true&warn=true',
      },

      {
        test: /Stylesheets\.elm$/,
        use: [
          'style-loader',
          'css-loader',
          'elm-css-webpack-loader'
        ]
      }
    ],

    noParse: /^((?!Stylesheet).)*\.elm.*$/,
  },

  devServer: {
    inline: true,
    stats: { colors: true },
  },
}
