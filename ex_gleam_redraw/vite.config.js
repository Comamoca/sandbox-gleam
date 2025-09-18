import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import gleam from "vite-gleam"
import tailwindcss from '@tailwindcss/vite'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), gleam(), tailwindcss()],
})
