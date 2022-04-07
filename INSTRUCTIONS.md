# Instalar Tailwind
- 1 - Acessar pasta `assets`
- 2 - Executar comando `npm install tailwindcss postcss autoprefixer --save-dev`

# Configurar Tailwind
- 1 - Acessar pasta `assets`
- 2 - Criar arquivo `postcss.config.js`
- 3 - Inserir configuração: 
```module.exports = {
    plugins: {
        tailwindcss: {},
        autoprefixer: {},
    },
}
```
- 4 - Executar comando `npx tailwindcss init`
- 5 - Configurar arquivo `tailwind.config.js` gerado:
  - i - em `content`, adicionar `'./js/**/*.js'`, `'../lib/*_web/**/*.*ex'`

# Adicionar importações
- 1 - Em `assets/css/app.css` importar `@tailwind base, components, utilities`

# Arquivo config/dev
Após `esbuild: []`, adicionar `npx: ["tailwindcss", "--input=css/app.css", "--output=../priv/static/assets/app.css", "--postcss", "--watch", cd: Path.expand("../assets", __DIR__)]`

# Configurar assets/package.json
- 1 - Adicionar configuração:
```
{
    "scripts": {
        "deploy": "NODE_ENV=production tailwindcss --postcss --minify --input=css/app.css --output=../priv/static/assets/app.css"
    },
    "devDependencies": {
        "autoprefixer": "^10.4.4",
        "postcss": "^8.4.12",
        "tailwindcss": "^3.0.23"
    }
}
```

# Configurar arquivo `mix.exs`
- 1 - Adicionar configuração na função `aliases`:
  ```    
  "assets.deploy": [
        "cmd --cd assets npm run deploy",
        "esbuild default --minify",
        "phx.digest"
    ]
```
