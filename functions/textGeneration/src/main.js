import { HfInference } from '@huggingface/inference';
import { throwIfMissing } from './utils.js';
import { getTarget } from './target_generator.js';

const hf = new HfInference(process.env.HUGGINGFACE_ACCESS_TOKEN);

export default async ({ req, res }) => {
  throwIfMissing(process.env, ['HUGGINGFACE_ACCESS_TOKEN']);

  if (req.method === 'GET') return res.json({ ok: false }, 400);

  if (req.bodyJson.prompt === undefined) return res.json({ ok: false, error: 'Prompt is required.' }, 400);
  if (req.bodyJson.seed === undefined) return res.json({ ok: false, error: 'seed is required.' }, 400);

  const seed = req.bodyJson.seed;
  if (!Number.isInteger(seed)) return res.json({ ok: false, error: 'seed must be an int.' }, 400); 

  const target = getTarget(seed);

  try {
    let response = await hf.chatCompletion({
      model: "Qwen/Qwen2.5-72B-Instruct",
      messages: [
        { role: "system", content: `You are participating in a game where you chose the character '${target.character}'.
           The user will ask you question to guess the character you chose. 
           You can ONLY answer with Yes, No, hint or success.
           Answer with 'hint' if the user is explicitly asking for a hint.
           Answer with 'success' if the user found your character.`
        },
        { role: "user", content: req.bodyJson.prompt }],
      max_tokens: 5,
    })

    let responseMessage = response.choices[0].message;

    if (responseMessage.content === undefined) {
      console.error(`Response message ${responseMessage} does not contain a 'content' value`);
      return res.json({ ok: false, error: 'Failed to query model.' }, 500);
    }

    if (responseMessage.content.toLocaleLowerCase().includes('hint')) {
      return res.json({ ok: true, answer: 'hint', hint: target.hint  }, 200);
    } 

    return res.json({ ok: true, answer: responseMessage.content }, 200);
  } catch (err) {
    console.error(err);
    return res.json({ ok: false, error: 'Failed to query model.' }, 500);
  }
};
