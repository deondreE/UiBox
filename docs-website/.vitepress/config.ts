import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
    title: "UiBox Documentation",
    description: "A SwiftUI Component library",
    themeConfig: {
        // https://vitepress.dev/reference/default-theme-config
        nav: [
            { text: "Home", link: "/" },
            { text: "Examples", link: "/examples" },
        ],

        sidebar: [
            {
                text: "Examples",
                items: [{ text: "Component Examples", link: "/examples" }],
            },
        ],

        socialLinks: [
            { icon: "github", link: "https://github.com/vuejs/vitepress" },
        ],
    },
});
