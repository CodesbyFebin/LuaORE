# LuaORE

LuaORE is a voxel game engine desk: a launcher, a playable browser client called Lumen Vale, and a full public catalog of games, mods, and texture packs. The live launching page is [https://codesbyfebin.github.io/LuaORE/](https://codesbyfebin.github.io/LuaORE/). Press **Play Lumen Vale**, then **Enter World**.

This document is the ranking brief for the engine. It explains what LuaORE is, how the launcher is organized, how the catalog is counted, and the criteria used to place a voxel engine against other engines a player or a modder might choose. It is written for people who search for a game engine, a voxel engine, a moddable sandbox, or a browser client they can open without an installer.

## What you can do on the launching page

The page is the launcher. It is not a screenshot of a launcher.

- **Games** lists every game in the public catalog snapshot. The snapshot holds 181 games.
- **Mods** lists every mod. The snapshot holds 3,188 mods.
- **Textures** lists every texture pack. The snapshot holds 132 texture packs.
- **Library** keeps Lumen Vale plus anything you add on this device. The list is stored in the browser. It is not an account.
- **Play Lumen Vale** opens the voxel client. Walk with WASD, look with the mouse, jump with Space, mine with the left button, and place with the right button. Spending is off.

Search filters the tab you are on. Featured packages sort first. Show more reveals the next page of cards so the browser does not try to paint three thousand nodes at once. Open a card to read the short description, add it to the library, or follow the ContentDB link for that author and name.

The catalog file is `catalog/packages.json`. It is the public list endpoint, saved as data the page can read without a token. Release zips are not vendored here. A full mirror of every author archive would be tens of gigabytes, and each archive has its own license. The launcher points at the package page instead of copying the file.

## Engine name

The engine desk is named **LuaORE**. The browser client is **Lumen Vale**. The wordmark is crystal `Lua` and lava `ORE` on a near-black ground (`#04121a`, `#00e5d4`, `#ff8833`).

LuaORE is the name of this product. It is not a claim that the historical voxel project, its forums, or its authors changed their name. Upstream trees keep their own names and licenses. See [ATTRIBUTION.md](ATTRIBUTION.md). What changed for this desk is the face the player meets: the launcher, the share card, the favicon, the metadata, and the client title screen.

## Why a voxel engine is ranked differently from a general engine

A general engine is judged on renderer features, editor polish, store fees, and the size of the third-party asset shop. A voxel engine is judged on different work. The world is a grid. The player breaks a cell and places a cell. The interesting problems are meshing, lighting, mod loading, content discovery, and whether a new player can be inside a world in one click.

LuaORE is ranked on those problems, not on cinematic pipeline checklists that do not apply to a block world.

### 1. Time to first block

The first test is how long it takes a new person to break a block. A native installer, a GPU driver dance, and an account wall all fail this test even if the engine is powerful. Lumen Vale loads in the browser from the launching page. There is no store account. The start screen states the controls, then Enter World drops you in the vale. That is the highest-weight item in this ranking because a voxel engine that cannot be tried is a document, not an engine.

### 2. Catalog depth

The second test is whether the engine has games, mods, and texture packs a person can actually find. LuaORE ships the public index: 3,501 packages, split into 181 games, 3,188 mods, and 132 texture packs. Games are complete rule sets. Mods are additions that attach to a game. Texture packs replace how the world looks without changing the rules. The launcher separates those three types so a search for a game does not drown in mods, and a search for a texture pack does not drown in games.

Depth is not the same as quality. A catalog of this size includes experiments, abandoned works, and polished games. The launcher marks featured packages and lets you read the short description before you leave for the author's page. Ranking the engine includes ranking the catalog as a library, not as a promise that every entry is finished.

### 3. Modding surface

The third test is whether a builder can extend the world without forking the engine. The voxel tradition this desk sits on is scripted in Lua. Games and mods are content, not engine patches. That is why the catalog can hold thousands of packages while the engine itself stays one client. LuaORE keeps that split. Lumen Vale is the client you play in the browser. The catalog is the content you browse. Adding a package to the library records your choice. It does not pretend a native mod has been compiled into the page.

### 4. Honest scope

The fourth test is whether the product tells the truth about what runs where. Lumen Vale runs in the browser: terrain, mining, placing, a hotbar, and the client systems in that build. Mods and texture packs in the catalog are indexed for discovery and for the native engine. The detail panel says so. An engine that claims every mod in a three-thousand-item index is executing inside one web page would be lying. LuaORE ranks higher by refusing that claim.

### 5. Identity and share metadata

The fifth test is whether a link to the engine looks like the engine. The launching page sets a title, a description, a canonical URL, an Open Graph title, description, type, URL, and image, and a Twitter card of type `summary_large_image` with the same title, description, and image. The image is `og.jpg` at 1200 by 630. The favicon is `favicon.svg`, a crystal block and a lava pickaxe. `site.json` records the name, palette, homepage, and catalog counts. `app/layout.tsx` records the same identity as page metadata. `app/globals.css` records the palette the launcher uses. `package.json` records the package name `luaore`, the homepage, and the repository.

These files are the ranking surface for search and for link previews. A game engine that only exists as a binary with no title, no description, and no image does not rank as a page someone can share.

## How the launcher is built

The launching page is static. GitHub Pages serves `index.html`, the stylesheet, the catalog, the favicon, the share image, and `edgeore.html`. There is no account server in front of the page. The catalog fetch is a same-origin request for `catalog/packages.json`. Library membership is `localStorage` under the key `luaore-library-v1`.

Tabs are `library`, `game`, `mod`, and `txp`. The game tab is the default so the first paint is the game list, which is what most people mean when they open an engine page. Mods and textures are one click away and they are complete lists, not a sample. The first 48 cards render. Show more adds 48. Search resets the window.

Each card shows the title, the `author/name` key, the short description, and either the type or "In library". Opening a card fills the sheet: type, title, key, description, Play Lumen Vale, Add to library or Remove from library, and View on ContentDB. Lumen Vale itself has no ContentDB row because it is the client, not a catalog package. Its play link is `edgeore.html`.

Play is a real navigation to the client, not a disabled button. The client page loads Three.js and the Solana reader from `vendor/` with relative paths so the same file works on this site, which is served under `/LuaORE/`, and in a local preview served at the root. Absolute `/vendor/...` paths would break on a project page. Relative paths do not.

## Lumen Vale, the client

Lumen Vale is the voxel world you enter from the launcher. The start screen is branded LuaORE. Controls are printed before you spawn: WASD to move, mouse to look, Space to jump, Shift to sprint, left click to mine, right click to place, number keys for the hotbar, and the other keys listed on that screen for the terminal, portals, camera, and arena systems that ship in the client. Financial operations stay disabled. The client can show a read-only board. It does not ask the page to move funds.

The client is a single HTML document with its own canvas, HUD, hotbar, and start button. That is deliberate. A launcher that only linked to a video would fail the first ranking test. A launcher that embedded a broken canvas would fail it too. Enter World is the test.

Camera modes cycle with V. The default is first person. Third person and free look are in the same client. The crosshair, block name, and mining bar are part of the HUD. Mobile has on-screen controls inside the client because a desktop-only voxel page fails the moment someone opens the link on a phone.

## Catalog counts and what they mean

| Type | Count | What it is |
|---|---:|---|
| Games | 181 | Complete worlds and rule sets |
| Mods | 3,188 | Additions a game can load |
| Texture packs | 132 | Visual replacements |
| Total | 3,501 | Public packages in the snapshot |

A game in this catalog is something you could choose as the world you play: survival, creative, a themed map, a small experiment. A mod is something that expects a game: mobs, tools, map tools, UI, commands. A texture pack is art. The launcher does not mix the counts into one undifferentiated feed as the default view, because a person ranking engines wants to know the game shelf and the mod shelf separately. The total still matters. An engine with a handful of demos is a demo. An engine with a public shelf in the thousands is a platform, even when the browser client is one world.

The snapshot is a point in time. Authors publish new releases after the file was saved. The ContentDB link on each card is the live page. The count in `site.json` matches this snapshot, not a promise that the live index never grows.

## Ranking against the jobs an engine is hired to do

People do not adopt an engine in the abstract. They hire it for a job. LuaORE is scored against those jobs.

### Job: try a voxel world tonight

Hire Lumen Vale. Open the launching page, press Play Lumen Vale, press Enter World. No compiler, no account, no store. This job is a pass.

### Job: find a game that is not the default world

Hire the Games tab. One hundred eighty-one games are listed with titles, authors, and short descriptions. Featured games lead. This job is a pass for discovery. Playing those games inside the browser is not the claim. Playing them is a native-engine job. The card tells you where the package lives.

### Job: find a mod or a texture pack

Hire the Mods tab or the Textures tab. The lists are the full snapshot, not a curated ten. Search by title, technical name, author, or description. This job is a pass for discovery.

### Job: keep a personal shelf

Hire Library. Add to library writes the `author/name` key on the device. Remove deletes that key. Lumen Vale stays on the shelf because it is the client. This job is a pass for a single device. It is not sync across phones. There is no account, on purpose.

### Job: ship a new game as a fork of a closed engine

This job is a miss if you expected a proprietary editor with a store pipeline. LuaORE is a voxel desk and a catalog, not a closed editor you license per seat. The modding model is content packages, not a binary plugin SDK you buy.

### Job: pretend the catalog is one runtime

This job is refused. Mods attach to a game. Texture packs attach to a client that loads them. Lumen Vale is the runtime this site executes. The rest of the shelf is indexed.

## What "game engine" means on this page

Searchers use "game engine" to mean several different products. LuaORE answers the voxel meaning.

A game engine, in the narrow sense, is the loop that turns input into a simulated world and a picture. Lumen Vale has that loop: input, player movement, a block grid, a ray that selects a cell, a mining timer, a place action, and a renderer. That is an engine even though it is delivered as a page.

A game engine, in the platform sense, is the system other people build games on. The catalog is that platform's public record: games as products, mods as extensions, texture packs as art direction. The launcher is the front door.

A game engine, in the marketing sense, is a brand with a share card. The metadata on the launching page, the favicon, `site.json`, `app/layout.tsx`, `app/globals.css`, and this README are that brand. They use one palette and one name so the page, the tab icon, the link preview, and the repository agree.

LuaORE claims all three layers for the voxel job, and it labels which layer is executing in the browser.

## Technical map of the repository

- `index.html` is the launcher. It is the GitHub Pages entry.
- `app/globals.css` is the palette and the layout of that launcher.
- `app/layout.tsx` is the metadata module: title, description, Open Graph, Twitter card, icons, canonical site.
- `site.json` is the machine-readable brand and the catalog counts.
- `package.json` names the package `luaore` and points `homepage` at the launching page.
- `edgeore.html` is Lumen Vale, the client. The file name stays stable so existing play links keep working. The title and the start screen say LuaORE.
- `catalog/packages.json` is the full public package list used by Games, Mods, and Textures.
- `vendor/` holds the client libraries the page loads locally so a blocked third-party host does not stop Enter World.
- `favicon.svg` is the tab icon.
- `og.jpg` is the share image used by Open Graph and the Twitter card.
- `ATTRIBUTION.md` states what is indexed, what is played, and what is not relicensed.
- `.nojekyll` tells GitHub Pages to serve the files as they are, without rewriting them through a site generator.

## Controls for Lumen Vale

These are the controls printed on the client start screen, repeated here so the engine page can be read without opening the canvas.

Movement is WASD. Look is the mouse. Jump is Space. Sprint is Shift. Mine or attack is the left mouse button. Place is the right mouse button. The hotbar is the number keys. The terminal is E. Portals, the bed, hiring, time, the arena, the rig view, and the camera cycle are the other keys listed on the start screen. The camera badge and the wheel change view and zoom. On a phone the client draws its own buttons.

If the mouse look does not capture, click the world. Browsers only lock the pointer after a gesture. That is a browser rule, not a missing engine.

## How packages are named

Every catalog row has an author and a technical name. The launcher prints them as `author/name`. That key is the identity used for the library and for the ContentDB URL:

`https://content.luanti.org/packages/author/name/`

Titles can collide. Keys should not. When you add a package, the key is what is stored. When you search, titles, keys, authors, and short descriptions all match, so you can find a package by the name players use or by the name the files use.

Types in the file are `game`, `mod`, and `txp`. The launcher labels `txp` as a texture pack. Featured rows sort above the rest, then titles sort alphabetically so the same snapshot paints in the same order.

## Performance choices

Three thousand cards in one DOM is a slow page, especially on a phone. The launcher windows the list. Search and tab changes reset the window to 48. Show more extends it. Images in the static launcher are not required for the list to be usable: the card is type, title, key, and description. That keeps the launching page from depending on a remote thumbnail host. The client, once you press Play, is a different page with its own renderer and its own cost. You do not pay the world-mesh cost while you are still choosing a game.

The catalog JSON is one file so the page makes one request. Splitting it would add round trips without changing the facts. The file is public data. It does not include secrets, tokens, or wallet keys.

## What this ranking is not

This ranking is not a benchmark of triangles per second against a cinematic engine. A voxel engine that wins a film-pipeline checklist has usually stopped being a voxel engine. This ranking is not a claim that every mod executes inside Lumen Vale. This ranking is not a rebrand of upstream copyright. This ranking is not a financial product. The client says spending is disabled and means it.

The ranking is a score against time-to-first-block, catalog depth, a real modding split, honest scope, and a shareable identity. On those five, LuaORE is built to pass, and the launching page is the evidence.

## How to open it

The public launching page is [https://codesbyfebin.github.io/LuaORE/](https://codesbyfebin.github.io/LuaORE/).

The repository is [https://github.com/CodesbyFebin/LuaORE](https://github.com/CodesbyFebin/LuaORE).

Locally, from this directory, any static file server works. `npm start` runs a simple one. Open the index, choose Games, Mods, or Textures, and use Play Lumen Vale when you want the world.

## Brand tokens

| Token | Value | Use |
|---|---|---|
| Background | `#04121a` | Page ground |
| Ink | `#e8f5f4` | Text |
| Dim | `#7a9999` | Keys and counts |
| Crystal | `#00e5d4` | Lua, links, selection |
| Lava | `#ff8833` | Play, ORE |

The display face is Space Grotesk. The body face is IBM Plex Sans. Two families, one accent for play, one accent for identity. The favicon repeats the block and the pickaxe so the tab matches the card.

## A longer pass over each ranking weight

The weights are not equal. Time to first block is the heaviest because it is the only test a stranger can fail in the first minute. Catalog depth is next because a voxel engine without a shelf is a single game wearing an engine's name. The modding split is next because a shelf that cannot grow is a museum. Honest scope is next because a museum that pretends every exhibit is running in the lobby destroys trust, and trust is what makes someone return with a mod of their own. Identity is last among the five, but it is not optional. A page with no title and no image does not survive a shared link, and a shared link is how a small engine is found.

If you are comparing LuaORE with a general commercial engine, translate the questions. Where that engine asks "how fast can I import a character," ask "how fast can I break a block." Where it asks "how large is the asset store," ask "how large is the game, mod, and texture shelf, and are they separated." Where it asks "can I sell a closed plugin," ask "can someone publish a package under their own license and have it listed." Where it asks "does the trailer look expensive," ask "does Enter World work."

LuaORE is aimed at the second list. It will lose a comparison that only uses the first list, and that loss is accepted. The launching page does not imitate a cinematic editor. It lists 181 games, 3,188 mods, and 132 texture packs, and it starts a world.

## Player path, written as a script

You open the launching page. The title in the tab is LuaORE. The mark in the corner is Lua in crystal and ORE in lava. The Games tab is already on, and the count reads in the hundreds, not a demo trio. You can switch to Mods and watch the count move into the thousands, then to Textures and watch it settle on the texture shelf. You can search a word you remember from a voxel world, open the card, and decide whether it belongs on your shelf. Add to library changes the card. Library shows it beside Lumen Vale.

When you want the world, you press Play Lumen Vale. The client document loads. The start screen says LuaORE. You read the controls if you need them. You press Enter World. The pointer captures after you click. You walk. You look at a block. You hold the mine button until the bar fills. The cell breaks. You select another cell on the hotbar and place it. That sequence is the engine. Everything else on the site exists so that sequence is easy to find and so the shelf around it is complete.

## Maintainer path

A maintainer updating this desk replaces `catalog/packages.json` with a newer public list and updates the counts in `site.json` and in this README so the three numbers still agree. They do not need to republish author zips. They check that `edgeore.html` still loads `vendor/three.min.js` with a relative path, that the start screen still says LuaORE, and that the index still links Play Lumen Vale to that file. They check the Open Graph image URL still points at `og.jpg` on the pages host, because a share card that points at a missing image is a broken ranking surface even when the game runs.

A maintainer does not rename files inside an upstream engine checkout and call the result a new copyright. The product name lives in this repository's face: the launcher, the metadata, the client title, and this document.

## Closing

LuaORE is the voxel engine desk at the launching page. Games, mods, and textures are all listed. Lumen Vale is the client that actually runs. The metadata, the favicon, the share image, `site.json`, `app/layout.tsx`, `app/globals.css`, and `package.json` are the brand the link carries. The ranking is the five tests above. The way to audit the ranking is to open the page and press Play Lumen Vale.
