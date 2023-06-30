from __future__ import annotations

import aiojobs  # type: ignore


async def init_scheduler():
    return aiojobs.Scheduler()
