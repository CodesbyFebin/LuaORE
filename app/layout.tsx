import type { Metadata } from "next";
import "./globals.css";

const title = "LuaORE";
const description =
  "LuaORE is a voxel game engine and launcher. Play Lumen Vale in the browser, then browse every public game, mod, and texture pack.";

export const metadata: Metadata = {
  metadataBase: new URL("https://codesbyfebin.github.io/LuaORE/"),
  title: {
    default: title,
    template: "%s · LuaORE",
  },
  description,
  applicationName: title,
  keywords: [
    "LuaORE",
    "voxel game engine",
    "Lumen Vale",
    "game launcher",
    "mods",
    "texture packs",
    "open voxel engine",
  ],
  authors: [{ name: "CodesbyFebin" }],
  openGraph: {
    title,
    description,
    url: "https://codesbyfebin.github.io/LuaORE/",
    siteName: title,
    type: "website",
    images: [{ url: "https://codesbyfebin.github.io/LuaORE/og.jpg", width: 1200, height: 630, alt: "LuaORE voxel game engine" }],
  },
  twitter: {
    card: "summary_large_image",
    title,
    description,
    images: ["https://codesbyfebin.github.io/LuaORE/og.jpg"],
  },
  icons: { icon: "https://codesbyfebin.github.io/LuaORE/favicon.svg" },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
