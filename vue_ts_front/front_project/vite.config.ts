import {defineConfig, loadEnv} from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'
import {createSvgIconsPlugin} from 'vite-plugin-svg-icons'
// https://vitejs.dev/config/
export default defineConfig(({command, mode}) => {
    // 获取各种环境的变量
    const env = loadEnv(mode, process.cwd())
    return {
        plugins: [
            vue(),
            createSvgIconsPlugin({
                // Specify the icon folder to be cached
                iconDirs: [path.resolve(process.cwd(), 'src/assets/icons')],
                // Specify symbolId format
                symbolId: 'icon-[dir]-[name]',
            }),
        ],
        resolve: {
            alias: {
                "@": path.resolve("./src") // 相对路径别名配置，使用 @ 代替 src
            }
        },
        css: {
            preprocessorOptions: {
                scss: {
                    javascriptEnabled: true,
                    additionalData: '@import "./src/styles/variable.scss";',
                },
            },
        },
        // 代理跨域
        server: {
            proxy: {
                [env.VITE_APP_BASE_API]: {
                    //获取数据的服务器地址设置
                    target: env.VITE_SERVE,
                    //需要代理跨域
                    changeOrigin: true,
                    //路径重写
                    rewrite: (path) => path.replace(/^\//, ''),
                },
            },
        },
    }
})
