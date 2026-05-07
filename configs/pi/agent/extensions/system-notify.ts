import { execFile, execFileSync } from "node:child_process";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const TITLE = "Pi";
const MESSAGE = "Pi needs your attention";

function run(command: string, args: string[]): void {
	const child = execFile(command, args, { windowsHide: true }, () => {
		// Ignore notification failures (missing notify-send, disabled notifications, etc.).
	});

	child.unref?.();
}

function getTmuxSessionName(): string | undefined {
	if (!process.env.TMUX) return undefined;

	try {
		const name = execFileSync("tmux", ["display-message", "-p", "#S"], {
			encoding: "utf8",
			timeout: 1000,
		}).trim();
		return name || undefined;
	} catch {
		return undefined;
	}
}

function notificationMessage(): string {
	const tmuxSession = getTmuxSessionName();
	return tmuxSession ? `${MESSAGE} (tmux: ${tmuxSession})` : MESSAGE;
}

function notify(): void {
	const message = notificationMessage();

	switch (process.platform) {
		case "darwin":
			run("osascript", [
				"-e",
				`display notification ${JSON.stringify(message)} with title ${JSON.stringify(TITLE)}`,
			]);
			break;
		case "linux":
			run("notify-send", [TITLE, message]);
			break;
	}
}

export default function (pi: ExtensionAPI) {
	pi.on("agent_end", async (_event, ctx) => {
		if (!ctx.hasUI) return;
		notify();
	});
}
