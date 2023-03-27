const countdown = (offerCreationTime, countdownDurationHours) => {
  const durationSec = countdownDurationHours * 60 * 60; // convert hours to seconds
  const creationDate = new Date(offerCreationTime);
  let diffSec = Math.floor((Date.now() - creationDate.getTime()) / 1000);
  let remainingSec = durationSec - diffSec;

  const intervalId = setInterval(() => {
    remainingSec--;
    if (remainingSec < 0) {
      clearInterval(intervalId);
      remainingSec = 0;
    }

    const hours = Math.floor(remainingSec / 3600);
    const minutes = Math.floor((remainingSec % 3600) / 60);
    const seconds = remainingSec % 60;

    console.log(`${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`);
  }, 1);
}

// Example usage: start a 24-hour countdown from the current time
const offerCreationTime = new Date().toISOString();
// const offerCreationTime = '2023-03-27T11:13:58.029Z'; //
// const offerCreationTime = '2023-03-26T11:13:58.029Z'; //  time shows 0
countdown(offerCreationTime, 24);
